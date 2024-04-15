class DropdownController {
    constructor(button, menu) {
        this.button = button;
        this.menu = menu;
        this.isOpen = false;

        this.button.addEventListener('click', this.toggleDropdown.bind(this));
        document.addEventListener('click', this.handleOutsideClick.bind(this));
    }

    toggleDropdown(){
        if (this.isOpen)
            this.closeDropdown();
        else
            this.openDropdown();
    }

    openDropdown() {
        this.menu.classList.remove('transaction', 'ease-in', 'duration-75', 'opacity-0', 'scale-95');
        this.menu.classList.add('transaction', 'ease-out', 'duration-100', 'opacity-100', 'scale-100')
        this.isOpen = true;
    }

    closeDropdown() {
        this.menu.classList.remove('transaction', 'ease-out', 'duration-100', 'opacity-100', 'scale-100')
        this.menu.classList.add('transaction', 'ease-in', 'duration-75', 'opacity-0', 'scale-95');
        this.isOpen = false;
    }

    handleOutsideClick(event) {
        if (!this.button.contains(event.target) && !this.menu.contains(event.target))
            this.closeDropdown();
    }
}