import { LightningElement, api } from "lwc";

export default class EdaSettingsNavigationSubsection extends LightningElement {
    @api viewModel;

    get menuItems() {
        if (!this.viewModel.menuItems) {
            return undefined;
        }

        let formattedMenuItems = [];

        this.viewModel.menuItems.forEach((menuItem) => {
            let formattedMenuItem = {
                label: menuItem.label,
                sectionKey: menuItem.sectionKey,
                page: this.viewModel.page,
            };
            formattedMenuItems.push(formattedMenuItem);
        });

        return formattedMenuItems;
    }

    handleNavigationClick() {
        this.dispatchSettingsNavigationEvent();
    }

    dispatchSettingsNavigationEvent() {
        const settingsNavigationDetail = {
            pageName: this.viewModel.page,
        };
        this.dispatchEvent(
            new CustomEvent("settingsnavigation", {
                detail: settingsNavigationDetail,
                bubbles: true,
                composed: true,
            })
        );
    }

    get subsectionHeaderClass() {
        let subsectionHeaderClass = "slds-p-horizontal_large slds-p-top_small slds-p-bottom_xx-small";

        if (this.viewModel.isActive) {
            subsectionHeaderClass += " eda-nav-is-active";
        }

        return subsectionHeaderClass;
    }

    get menuItemClass() {
        let menuItemClass = "slds-p-left_x-large slds-truncate";

        if (this.viewModel.isActive) {
            menuItemClass += " eda-nav-is-active";
        }

        return menuItemClass;
    }
}
