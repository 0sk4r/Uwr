/**
 * Created by oskar on 26.11.2016.
 */
var Card = (function () {
    function Card(element) {
        this.element = element;
        var src = element.firstChild['src'];
        this.value = parseInt(/(\d+)\.png/g.exec(src)[1]);
        this.found = false;
    }
    Card.prototype.hide = function () {
        $(this.element).addClass('card-hidden');
    };
    Card.prototype.isPair = function (other) {
        return this.value == other.value;
    };
    Card.prototype.onSelect = function (func) {
        var that = this;
        $(this.element).click(function () {
            if (!that.found)
                func(that);
        });
    };
    Card.prototype.show = function () {
        $(this.element).removeClass('card-hidden');
        $(this.element.firstChild).hide().slideDown();
    };
    Card.prototype.matchFound = function () {
        this.found = true;
    };
    return Card;
}());
