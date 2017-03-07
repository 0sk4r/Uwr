var Card = (function () {
    function Card(file) {
        this.element = document.createElement("div");
        this.element.setAttribute("class", "card");
        var img = document.createElement("img");
        img.setAttribute("src", "cards/" + file);
        this.element.appendChild(img);
        this.name = file;
        this.found = false;
    }
    Card.prototype.hideCard = function () {
        $(this.element).addClass('card-hidden');
    };
    Card.prototype.match = function (card) {
        return this.name == card.name;
    };
    Card.prototype.onSelect = function (func) {
        var that = this;
        $(this.element).click(function () {
            if (!that.found)
                func(that);
        });
    };
    Card.prototype.showCard = function () {
        $(this.element).removeClass('card-hidden');
        $(this.element.firstChild).hide().fadeToggle();
    };
    Card.prototype.setFound = function () {
        this.found = true;
    };
    return Card;
}());
/// <reference path="typings/jquery.d.ts" />
/// <reference path="Card.ts" />
var Game = (function () {
    function Game() {
        this.fileList = [
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
        this.startTime = new Date();
        this.cards = this.makeCards();
        Game.random(this.cards);
        this.drawCards();
        this.select1 = null;
        this.select2 = null;
    }
    Game.prototype.makeCards = function () {
        return Array.prototype.map.call(this.fileList, function (el, i) {
            return new Card(el);
        });
    };
    Game.random = function (o) {
        var j, x, i = o.length;
        for (; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x)
            ;
    };
    Game.prototype.drawCards = function () {
        var that = this;
        this.cards.forEach(function (card) {
            card.hideCard();
            $('.board').append(card.element);
            card.onSelect(function (card) {
                that.cardSelected(card);
            });
        });
    };
    Game.prototype.cardSelected = function (card) {
        if (!this.select1) {
            card.showCard();
            this.select1 = card;
        }
        else if (card == this.select1) {
            return;
        }
        else if (!this.select2) {
            card.showCard();
            this.select2 = card;
            this.checkCards();
        }
        else {
            this.select1.hideCard();
            this.select2.hideCard();
            this.select1 = null;
            this.select2 = null;
        }
    };
    Game.prototype.checkCards = function () {
        if (this.select1 == this.select2)
            return;
        if (!this.select1.match(this.select2))
            return;
        this.select1.setFound();
        this.select2.setFound();
        this.select1 = null;
        this.select2 = null;
        this.checkAllFound();
    };
    Game.prototype.checkAllFound = function () {
        var allCardsFound = this.cards.every(function (card, _1, _2) {
            return card.found;
        });
        if (allCardsFound) {
            var stopTime = new Date();
            alert("Udało ci się! Twój czas to: " + (stopTime.getTime() - this.startTime.getTime()) / 1000 + " sekund");
        }
    };
    return Game;
}());
/// <reference path="Game.ts" />
$(document).ready(function () {
    new Game();
});
