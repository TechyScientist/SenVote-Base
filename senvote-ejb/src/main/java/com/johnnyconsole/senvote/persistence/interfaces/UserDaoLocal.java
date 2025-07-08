package com.johnnyconsole.senvote.persistence.interfaces;

import com.johnnyconsole.senvote.persistence.User;

import javax.ejb.Local;
import java.util.List;

@Local
public interface UserDaoLocal {

    User getUser(String username);
    boolean userExists(String username);
    long userCount();
    List<User> getUsersExcept(String username);
    boolean addUser(User user);
    boolean removeUser(User user, String myUsername);
    boolean saveUser(User user);
    boolean verifyUser(String username, String passwordPlainText);

}
