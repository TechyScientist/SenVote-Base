package com.johnnyconsole.senvote.persistence;

import javax.persistence.*;

@Entity
@Table(name="senvote_users")
@NamedQueries({
        @NamedQuery(name="User.FindByUsername", query="SELECT u FROM User u WHERE u.username = :username"),
        @NamedQuery(name="User.FindCount", query="SELECT COUNT(u) FROM User u"),
        @NamedQuery(name="User.FindAllExcept", query="SELECT u FROM User u WHERE u.username != :username")
})
public class User {

    @Id
    private String username;
    private String name, password;
    private int accessLevel;

    public User() {}

    public User(String username, String name, String password, int accessLevel) {
        this.username = username;
        this.name = name;
        this.password = password;
        this.accessLevel = accessLevel;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getAccessLevel() {
        return accessLevel;
    }

    public void setAccessLevel(int accessLevel) {
        this.accessLevel = accessLevel;
    }

    @Override
    public String toString() {
        return "User[username=" + username + ", name=" + name + ", accessLevel=" + accessLevel + "]";
    }
}
