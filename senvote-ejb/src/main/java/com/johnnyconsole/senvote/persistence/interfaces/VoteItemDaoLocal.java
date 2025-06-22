package com.johnnyconsole.senvote.persistence.interfaces;

import com.johnnyconsole.senvote.persistence.VoteItem;

import javax.ejb.Local;
import java.util.List;

@Local
public interface VoteItemDaoLocal {

    VoteItem byId(int id);
    List<VoteItem> all();
    List<VoteItem> active();
    void addVoteItem(VoteItem voteItem);
    void removeVoteItem(VoteItem voteItem);

}
