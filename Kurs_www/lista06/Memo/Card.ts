    class Card {
        element: Element;
        name: string;
        found: boolean;

        constructor(file: string) {
            this.element = document.createElement("div");
            this.element.setAttribute("class", "card");

            let img = document.createElement("img");
            img.setAttribute("src","cards/" +  file);

            this.element.appendChild(img);
            
            this.name = file;
            this.found = false;
        }

        hideCard(): void {
            $(this.element).addClass('card-hidden');
        }

        match(card: Card): boolean {
            return this.name == card.name
        }

        onSelect(func) {
            let that = this;
            $(this.element).click(function () {
                if (!that.found)
                    func(that);
            });
        }

        showCard(): void {
            $(this.element).removeClass('card-hidden');
            $(this.element.firstChild).hide().fadeToggle();
        }

        setFound(): void {
            this.found = true;
        }
    }
