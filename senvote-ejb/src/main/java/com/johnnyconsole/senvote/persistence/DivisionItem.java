package com.johnnyconsole.senvote.persistence;

import javax.persistence.*;
import java.sql.Date;

@Entity
@Table(name="senvote_divisionitems")
@NamedQueries({
        @NamedQuery(name="DivisionItem.FindByID", query="SELECT v FROM DivisionItem v WHERE v.id = :id"),
        @NamedQuery(name="DivisionItem.FindCount", query="SELECT COUNT(v) AS count FROM DivisionItem v"),
        @NamedQuery(name="DivisionItem.FindActiveCount", query="SELECT COUNT(v) AS count FROM DivisionItem v WHERE v.start >= NOW() AND v.end <= NOW()"),
        @NamedQuery(name="DivisionItem.FindAll", query="SELECT v FROM DivisionItem v"),
        @NamedQuery(name="DivisionItem.FindActive", query="SELECT v FROM DivisionItem v WHERE v.start >= NOW() AND v.end <= NOW()")
})
public class DivisionItem {

    @Id
    public int id;
    public String type, title, text;
    public Date start, end;

    public DivisionItem() {}

    public DivisionItem(int id, String type, String title, String text, Date start, Date end) {
        this.id = id;
        this.type = type;
        this.title = title;
        this.text = text;
        this.start = start;
        this.end = end;
    }

}
