package UML.browser;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Page {

	private String address;
	public Page(String address){
		this.address=address;
	}

	public void Respose() {
		System.out.println("Server seend ...Response from "+this.getAddress());
	}
}
