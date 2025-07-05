package com.johnnyconsole.senvote.persistence.interfaces;

import com.johnnyconsole.senvote.persistence.DivisionItem;

import javax.ejb.Local;
import java.util.List;

@Local
public interface DivisionItemDao {

    DivisionItem byId(int id);
    List<DivisionItem> all();
    List<DivisionItem> active();
    int count();
    void addDivisionItem(DivisionItem item);
    void removeDivisionItem(DivisionItem item);

}
