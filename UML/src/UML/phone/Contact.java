package UML.phone;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.Arrays;

@Getter
@Setter
public class Contact {
	private String name="Unknow";
	private ArrayList<PhoneNumber> numbers=new ArrayList<PhoneNumber>();

	private boolean blocked=false;

	public void blockContact() {
       if(blocked){
			this.blocked=false;
	   }else{
		   this.blocked=true;
	   }
	}

	public Contact(String name,PhoneNumber ... number){
		this.name=name;
		this.addNumber(number);
	}

	public void addNumber(PhoneNumber ... number){
		Arrays.stream(number).forEach(n->{this.numbers.add(n);});
	}

	public void removeNumber(PhoneNumber ... number){
		Arrays.stream(number).forEach(n->{
			if(this.numbers.contains(n)){
				this.numbers.remove(n);
			}
		});
	}

	@Override
	public String toString(){
		return "Contact "+this.name+" "+this.getNumbers().toString();
	}


}
