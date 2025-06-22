package com.johnnyconsole.senvote.persistence.impl;

import com.johnnyconsole.senvote.persistence.VoteItem;
import com.johnnyconsole.senvote.persistence.interfaces.VoteItemDaoLocal;

import javax.ejb.Stateful;
import javax.enterprise.inject.Alternative;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

@Stateful
@Alternative
public class VoteItemDaoImpl implements VoteItemDaoLocal {

    @PersistenceContext(unitName="voteitem")
    private EntityManager manager;

    @Override
    public VoteItem byId(int id) {
        try {
            Query query = manager.createNamedQuery("VoteItem.FindByID");
            query.setParameter("id", id);
            return (VoteItem) query.getSingleResult();
        } catch(Exception e) {
            return null;
        }
    }

    @Override
    public List<VoteItem> all() {
        try {
            Query query = manager.createNamedQuery("VoteItem.FindAll");
            return (List<VoteItem>) query.getResultList();
        } catch(Exception e) {
            return null;
        }
    }

    public List<VoteItem> active() {
        try {
            Query query = manager.createNamedQuery("VoteItem.FindActive");
            return (List<VoteItem>) query.getResultList();
        }  catch(Exception e) {
            return null;
        }
    }

    @Override
    public void addVoteItem(VoteItem voteItem) {

    }

    @Override
    public void removeVoteItem(VoteItem voteItem) {

    }

}
