package UML.phone;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PhoneNumber {

	private String countryPrefix;

	private String regionPrefix;

	private String phoneNumber;

	public PhoneNumber(String countryPrefix,String regionPrefix,String phoneNumber){
		this.phoneNumber=phoneNumber;
		this.countryPrefix=countryPrefix;
		this.regionPrefix=regionPrefix;
	}
@Override
public String toString(){
		return this.countryPrefix+"-"+this.regionPrefix+"-"+this.phoneNumber;
}

}
