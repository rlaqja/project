package com.multi.gazee.member;

import org.mindrot.jbcrypt.BCrypt;

public class Bcrypt {
	
	public String encrypt(String password) {
	    return BCrypt.hashpw(password, BCrypt.gensalt());
	}
	
}
