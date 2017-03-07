/// <reference path="typings/jquery.d.ts" />
/// <reference path="Card.ts" />


class Game {
    private fileList: string[] = [
        "0.png",
        "1.png",
        "2.png",
        "3.png",
        "4.png",
        "5.png",
        "6.png",
        "7.png",
        "0.png",
        "1.png",
        "2.png",
        "3.png",
        "4.png",
        "5.png",
        "6.png",
        "7.png"
    ];

    private cards: Card[];
    private select1: Card;
    private select2: Card;

    private startTime: Date;

    constructor() {
        this.startTime = new Date();
        this.cards = this.makeCards();
        Game.random(this.cards);
        this.drawCards();
        this.select1 = null;
        this.select2 = null;
    }

    private makeCards(): Card[] {
        return Array.prototype.map.call(this.fileList, function (el, i) {
            return new Card(el);
        });
    }

    private static random(o) {
        let j, x, i = o.length;
        for (; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
    }

    private drawCards(): void {
        let that = this;
        this.cards.forEach(function (card) {
            card.hideCard();
            $('.board').append(card.element);
            card.onSelect(function (card: Card) {
                that.cardSelected(card);
            });
        });
    }

    cardSelected(card: Card): void {
        if (!this.select1) {
            card.showCard();
            this.select1 = card;
        } else if (card == this.select1){
            return;
        }
        else if (!this.select2) {
            card.showCard();
            this.select2 = card;
            this.checkCards();
        } else {
            this.select1.hideCard();
            this.select2.hideCard();
            this.select1 = null;
            this.select2 = null;
        }
    }

    private checkCards(): void {
        if (this.select1 == this.select2)
            return;

        if (!this.select1.match(this.select2))
            return;

        this.select1.setFound();
        this.select2.setFound();

        this.select1 = null;
        this.select2 = null;

        this.checkAllFound();
    }

    private checkAllFound(): void {
        let allCardsFound = this.cards.every(function (card: Card, _1, _2): boolean {
            return card.found;
        });
        if (allCardsFound) {
            let stopTime = new Date();
            alert("Udało ci się! Twój czas to: " + (stopTime.getTime() - this.startTime.getTime())/1000 + " sekund");
        }
    }
}