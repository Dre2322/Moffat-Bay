/* Registration Beans Alpha Team
   Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh */

package moffatbay;

//Getters and Setters for Registration Form Page
public class RegistrationBeans implements java.io.Serializable {

	private String fname;
	private String lname;
	private String email;
	private String phone;
	private String pass;
	private String confpass;
	
	private String address;
	private String city;
	private String state;
	private String zip;
	
	private int userid;
	
	public RegistrationBeans() {
	}
	
	//Required Entries (Getters) for Registration Page
	public String getFirstName() {
		return fname;
	}
	
	public String getLastName() {
		return lname;
	}
	
	public String getEmailAddress() {
		return email;
	}
	
	public String getPhoneNum() {
		return phone;
	}
	
	public String getPassword() {
		return pass;
	}
	
	public String getConfirmPassword() {
		return confpass;
	}
	
	//Optional Entries (Getters) for Registration Page
	public String getAddress() {
		return address;
	}
	
	public String getCity() {
		return city;
	}
	
	public String getState() {
		return state;
	}
	
	public String getZipcode() {
		return zip;
	}
	
	//New User ID Getter
	public int getNewUserID() {
		return userid;
	}
	
	//Required Entries (Setters) for Registration Page
	public void setFirstName(String fname) {
		this.fname = fname;
	}
	
	public void setLastName(String lname) {
		this.lname = lname;
	}
	
	public void setEmailAddress(String email) {
		this.email = email;
	}
	
	public void setPhoneNum(String phone) {
		this.phone = phone;
	}
	
	public void setPassword(String pass) {
		this.pass = pass;
	}
	
	public void setConfirmPassword(String confpass) {
		this.confpass = confpass;
	}
	
	//Optional Entries (Setters) for Registration Page
	public void setAddress(String address) {
		this.address = address;
	}
	
	public void setCity(String city) {
		this.city = city;
	}
	
	public void setState(String state) {
		this.state = state;
	}
	
	public void setZipcode(String zip) {
		this.zip = zip;
	}
	
	//New User ID Setter
	public void setNewUserID(int userid) {
		this.userid = userid;
	}
}
