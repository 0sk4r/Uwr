/// <reference path="typings/jquery.d.ts" />
/// <reference path="Card.ts" />


class Game {
    private Images = [
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
    private selectedCard1: Card;
    private selectedCard2: Card;

    private startTime: Date;
    constructor() {
        this.startTime = new Date();
        console.log(this.startTime);
        this.cards = this.initCards();
        this.shuffleCards();
        this.drawCards();
        this.selectedCard1 = null;
        this.selectedCard2 = null;
    }

    private shuffleCards(): void {
        Game.shuffle(this.cards);
    }

    private initCards(): Card[] {
        //let elements = document.getElementsByClassName('card');
        let elements = this.Images;
        return Array.prototype.map.call(elements, function (el, i) {
            return new Card(el);
        });
    }

    // from http://stackoverflow.com/questions/6274339/how-can-i-shuffle-an-array-in-javascript
    private static shuffle(o) {
        let j, x, i = o.length;
        for (; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
    }

    private drawCards(): void {
        let that = this;
        $('.game-field').empty();
        this.cards.forEach(function (el) {
            el.hide();
            $('.game-field').append(el.element);
            el.onSelect(function (card: Card) {
                that.cardSelected(card);
            });
        });
    }

    cardSelected(card: Card): void {
        if (!this.selectedCard1) {
            card.show();
            this.selectedCard1 = card;
        } else if (!this.selectedCard2) {
            card.show();
            this.selectedCard2 = card;
            this.checkCards();
        } else {
            this.selectedCard1.hide();
            this.selectedCard2.hide();
            this.selectedCard1 = null;
            this.selectedCard2 = null;
        }
    }

    private checkCards(): void {
        // check if clicked two times on the same card
        if (this.selectedCard1 == this.selectedCard2)
            return;

        // if cards don't match, return
        if (!this.selectedCard1.isPair(this.selectedCard2))
            return;

        // yay, cards match!
        this.selectedCard1.matchFound();
        this.selectedCard2.matchFound();

        this.selectedCard1 = null;
        this.selectedCard2 = null;

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