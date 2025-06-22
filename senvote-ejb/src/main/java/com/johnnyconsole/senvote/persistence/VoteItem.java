package com.johnnyconsole.senvote.persistence;

import javax.persistence.*;
import java.sql.Date;

@Entity
@Table(name="senvote_voteitems")
@NamedQueries({
        @NamedQuery(name="VoteItem.FindByID", query="SELECT v FROM VoteItem v WHERE v.id = :id"),
        @NamedQuery(name="VoteItem.FindCount", query="SELECT COUNT(v) FROM VoteItem v"),
        @NamedQuery(name="VoteItem.FindAll", query="SELECT v FROM VoteItem v"),
        @NamedQuery(name="VoteItem.FindActive", query="SELECT v FROM VoteItem v WHERE v.start >= NOW() AND v.end <= NOW()")
})
public class VoteItem {

    @Id
    public int id;
    public String type, title, text;
    public Date start, end;

    public VoteItem() {}

    public VoteItem(int id, String type, String title, String text, Date start, Date end) {
        this.id = id;
        this.type = type;
        this.title = title;
        this.text = text;
        this.start = start;
        this.end = end;
    }

}
