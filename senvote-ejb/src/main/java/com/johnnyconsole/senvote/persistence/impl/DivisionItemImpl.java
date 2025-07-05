package com.johnnyconsole.senvote.persistence.impl;

import com.johnnyconsole.senvote.persistence.DivisionItem;
import com.johnnyconsole.senvote.persistence.interfaces.DivisionItemDaoLocal;

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
    public boolean addDivisionItem(DivisionItem item) {
        try {
            manager.persist(item);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public boolean removeDivisionItem(DivisionItem item) {
        return false;
    }

    @Override
    public boolean saveDivisionItem(DivisionItem item) {
        return false;
    }

}
