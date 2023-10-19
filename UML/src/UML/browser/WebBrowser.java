package UML.browser;

import java.util.ArrayList;

public class WebBrowser {
	private ArrayList<Page> tabs=new ArrayList<>();

	public void renderPage(Page p) {
		System.out.println("Acessando Pagina address "+p.getAddress());
	}

	public void addNewTab(Page p) {
		System.out.println("add Page to tabs "+p.getAddress());
		tabs.add(p);
	}

	public void removeTab(Page p) {
       if(tabs.contains(p)){
		   System.out.println("remove Page to tabs "+p.getAddress());
		   tabs.remove(p);
	   }
	}

	public void refreshPage(Page p) {
		System.out.println("Refreshing Page: "+p.getAddress());
		p.Respose();
	}
	public WebBrowser(){}

}
