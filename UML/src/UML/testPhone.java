package UML;

import UML.phone.Contact;
import UML.phone.Iphone;
import UML.phone.PhoneNumber;

public class testPhone {
    public static void main(String[] args) {
        var iphone=new Iphone();

        var phone1=new PhoneNumber("55","012","9999999");
        System.out.println(phone1.toString());
        var phone2=new PhoneNumber("32","002","8888888");
        System.out.println(phone2.toString());
        var phone3=new PhoneNumber("12","102","8444488");
        System.out.println(phone3.toString());
        var phone4=new PhoneNumber("01","299","0988888");
        System.out.println(phone4.toString());

        var contact1=new Contact("Jolie",phone1);
        contact1.addNumber(phone2);
        //contact1.removeNumber(phone2);
        System.out.println(contact1.toString());

        var contact2=new Contact("Hagnar",phone3);
        System.out.println(contact2.toString());

        iphone.call(contact2);
        iphone.answerCall(contact1);

        iphone.voiceMail(contact1,contact2);

    }

}
