    /**
     * Created by oskar on 26.11.2016.
     */
    class Card {
        element: Element;
        value: string;
        found: boolean;

        constructor(element: string) {
            this.element = document.createElement("div");
            this.element.setAttribute("class", "card");

            let img = document.createElement("img");
            img.setAttribute("src","images/cards/" +  element);
            this.element.appendChild(img);
            this.value = element;
            this.found = false;
        }

        hide(): void {
            $(this.element).addClass('card-hidden');
        }

        isPair(other: Card): boolean {
            return this.value == other.value
        }

        onSelect(func) {
            let that = this;
            $(this.element).click(function () {
                if (!that.found)
                    func(that);
            });
        }

        show(): void {
            $(this.element).removeClass('card-hidden');
            $(this.element.firstChild).hide().slideDown();
        }

        matchFound(): void {
            this.found = true;
        }
    }
