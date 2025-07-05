package com.johnnyconsole.senvote.persistence.impl;

import com.johnnyconsole.senvote.persistence.interfaces.DivisionItemDaoLocal;
import com.johnnyconsole.senvote.persistence.DivisionItem;

import javax.ejb.Stateful;
import javax.enterprise.inject.Alternative;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

@Stateful
@Alternative
public class DivisionItemImpl implements DivisionItemDaoLocal {

    @PersistenceContext(unitName="divisionitem")
    private EntityManager manager;

    @Override
    public DivisionItem byId(int id) {
        try {
            Query query = manager.createNamedQuery("DivisionItem.FindByID");
            query.setParameter("id", id);
            return (DivisionItem) query.getSingleResult();
        } catch(Exception e) {
            return null;
        }
    }

    @Override
    public List<DivisionItem> all() {
        try {
            Query query = manager.createNamedQuery("DivisionItem.FindAll");
            return (List<DivisionItem>) query.getResultList();
        } catch(Exception e) {
            return null;
        }
    }

    @Override
    public List<DivisionItem> active() {
        try {
            Query query = manager.createNamedQuery("DivisionItem.FindActive");
            return (List<DivisionItem>) query.getResultList();
        }  catch(Exception e) {
            return null;
        }
    }

    @Override
    public int count() {
        try {
            return all().size();
        }  catch(Exception e) {
            return 0;
        }
    }

    @Override
    public int activeCount() {
        try {
            return active().size();
        }  catch(Exception e) {
            return 0;
        }
    }

    @Override
    public void addDivisionItem(DivisionItem item) {

    }

    @Override
    public void removeDivisionItem(DivisionItem item) {

    }

    @Override
    public void saveDivisionItem(DivisionItem item) {

    }

}
