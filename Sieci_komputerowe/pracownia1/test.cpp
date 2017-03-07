while (true) {
		fd_set descriptors;
		FD_ZERO(&descriptors);
		FD_SET(sockfd, &descriptors);
		struct timeval timeout;
		timeout.tv_sec = timeLimit/1000;
		timeout.tv_usec = (timeLimit%1000)*1000;
		int ready = select(sockfd+1, &descriptors, NULL, NULL, &timeout);

		if (ready) {
			std::string from;
			struct sockaddr_in sender;
			socklen_t senderLen = sizeof(sender);
			bufferPtr = buffer;
			
			recvfrom(sockfd, bufferPtr, IP_MAXPACKET, 0, (struct sockaddr*)&sender, &senderLen);

			char str[20];
			inet_ntop(AF_INET, &(sender.sin_addr), str, sizeof(str));
			from = str;

			struct ip* packet = (struct ip*)bufferPtr;
			bufferPtr += packet->ip_hl*4;

			struct icmp* icmpPacket = (struct icmp*)bufferPtr;
			bufferPtr += 8;
			
			if ((icmpPacket->icmp_type == ICMP_TIME_EXCEEDED) && (icmpPacket->icmp_code == ICMP_EXC_TTL)) {
				struct ip* packetOrig = (struct ip*)bufferPtr;
				bufferPtr += packetOrig->ip_hl*4;

				struct icmp* icmpPacketOrig = (struct icmp*)bufferPtr;
				bufferPtr += 8;

				int id = icmpPacketOrig->icmp_id, seq = icmpPacketOrig->icmp_seq;

				if ((id == ident) && (seq > pkgCount*ttl) && (seq <= pkgCount*(ttl+1))) {
					gettimeofday(&time, NULL);
					long long curTime = ((long long)time.tv_sec*1000) + (time.tv_usec/1000);
					sumTime += curTime-startTime;
					numAnsw++;
					if (std::find(answer.from.begin(), answer.from.end(), from) == answer.from.end())
						answer.from.push_back(from);
					answer.wasAnswer = true;
				}
			}
			else if (icmpPacket->icmp_type == ICMP_ECHOREPLY) {
				int id = icmpPacket->icmp_id, seq = icmpPacket->icmp_seq;

				if ((id == ident) && (seq > pkgCount*ttl) && (seq <= pkgCount*(ttl+1))) {
					gettimeofday(&time, NULL);
					long long curTime = ((long long)time.tv_sec*1000) + (time.tv_usec/1000);
					sumTime += curTime-startTime;
					numAnsw++;
					if (std::find(answer.from.begin(), answer.from.end(), from) == answer.from.end())
						answer.from.push_back(from);
					answer.wasAnswer = true;
					answer.finalAnswer = true;
				}
			}

			if (numAnsw > 0)
				answer.avgTime = sumTime/numAnsw;
			else
				answer.avgTime = -1;
		}
		else
			break;
	}

	return answer;
}