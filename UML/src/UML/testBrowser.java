package UML;

import UML.browser.Page;
import UML.browser.WebBrowser;

public class testBrowser {
    public static void main(String[] args) {

        var web=new WebBrowser();
        var page1=new Page("banco.com");
        var page2=new Page("sorveteria.com");

        web.addNewTab(page1);
        web.addNewTab(page2);
        web.removeTab(page1);
        web.refreshPage(page2);

    }
}
