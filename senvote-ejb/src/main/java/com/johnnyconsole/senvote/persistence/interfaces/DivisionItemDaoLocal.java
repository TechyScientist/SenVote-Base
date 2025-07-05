package com.johnnyconsole.senvote.persistence.interfaces;

import com.johnnyconsole.senvote.persistence.DivisionItem;

import javax.ejb.Local;
import java.util.List;

@Local
public interface DivisionItemDaoLocal {

    DivisionItem byId(int id);
    List<DivisionItem> all();
    List<DivisionItem> active();
    int count();
    int activeCount();
    boolean addDivisionItem(DivisionItem item);
    boolean removeDivisionItem(DivisionItem item);
    boolean saveDivisionItem(DivisionItem item);

}
