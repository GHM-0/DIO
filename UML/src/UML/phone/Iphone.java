package UML.phone;

import java.util.ArrayList;
import java.util.Arrays;

public class Iphone {
	private ArrayList<PhoneNumber> numbers=new ArrayList<PhoneNumber>(1);

	public void call(Contact p) {
		System.out.println("Calling to "+p.getName()+" at Number "+p.getNumbers().getFirst());
	}

	public void answerCall(Contact p) {
		System.out.println("Receiving call from "+p.getName()+" at "+p.getNumbers().getFirst());
	}

	public void voiceMail(Contact... p) {
		Arrays.stream(p).forEach(
				contact ->{ System.out.println("voiceMail to "+ contact.getName());});
	}

}
