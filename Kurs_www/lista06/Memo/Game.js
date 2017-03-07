/// <reference path="typings/jquery.d.ts" />
/// <reference path="Card.ts" />
var Game = (function () {
    function Game() {
        this.Images = [
            "1.png",
            "2.png",
            "3.png",
            "4.png",
            "5.png",
            "6.png",
            "7.png",
            "8.png",
            "9.png",
            "10.png",
        ];
        this.cards = this.initCards();
        this.shuffleCards();
        this.drawCards();
        this.selectedCard1 = null;
        this.selectedCard2 = null;
    }
    Game.prototype.shuffleCards = function () {
        Game.shuffle(this.cards);
    };
    Game.prototype.initCards = function () {
        var elements = document.getElementsByClassName('card');
        return Array.prototype.map.call(elements, function (el, i) {
            return new Card(el);
        });
    };
    // from http://stackoverflow.com/questions/6274339/how-can-i-shuffle-an-array-in-javascript
    Game.shuffle = function (o) {
        var j, x, i = o.length;
        for (; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x)
            ;
    };
    Game.prototype.drawCards = function () {
        var that = this;
        $('.game-field').empty();
        this.cards.forEach(function (el) {
            el.hide();
            $('.game-field').append(el.element);
            el.onSelect(function (card) {
                that.cardSelected(card);
            });
        });
    };
    Game.prototype.cardSelected = function (card) {
        if (!this.selectedCard1) {
            card.show();
            this.selectedCard1 = card;
        }
        else if (!this.selectedCard2) {
            card.show();
            this.selectedCard2 = card;
            this.checkCards();
        }
        else {
            this.selectedCard1.hide();
            this.selectedCard2.hide();
            this.selectedCard1 = null;
            this.selectedCard2 = null;
        }
    };
    Game.prototype.checkCards = function () {
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
    };
    Game.prototype.checkAllFound = function () {
        var allCardsFound = this.cards.every(function (card, _1, _2) {
            return card.found;
        });
        if (allCardsFound) {
            $('body').html('Congrats, you have won!');
        }
    };
    return Game;
}());
