package ca.jrvs.apps.trading.dao;

import ca.jrvs.apps.trading.config.TestConfig;
import ca.jrvs.apps.trading.model.domain.*;
import org.assertj.core.util.Lists;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.context.junit4.SpringRunner;

import javax.swing.text.html.Option;
import java.time.LocalDate;
import java.util.*;

import static org.junit.Assert.assertEquals;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = {TestConfig.class})
@Sql({"classpath:schema.sql"})
public class PositionDaoIntTest {
    @Autowired
    private SecurityOrderDao securityOrderDao;
    @Autowired
    private AccountDao accountDao;
    @Autowired
    private TraderDao traderDao;
    @Autowired
    private QuoteDao quoteDao;
    @Autowired
    private PositionDao positionDao;

    private Quote savedQuote;
    private SecurityOrder savedOrder;
    private Account savedAccount;
    private Trader savedTrader;


    @Before
    public void insertOne() {
        savedQuote = new Quote();
        savedQuote.setAskPrice(10d);
        savedQuote.setAskSize(10);
        savedQuote.setBidPrice(10.2d);
        savedQuote.setBidSize(10);
        savedQuote.setID("FB");
        savedQuote.setLastPrice(10.1d);
        quoteDao.save(savedQuote);

        savedTrader = new Trader();
        LocalDate dateOfBirth = LocalDate.of(1999, 5, 4);
        savedTrader.setCountry("Canada");
        savedTrader.setDob(dateOfBirth);
        savedTrader.setEmail("andre@gmail.com");
        savedTrader.setFirstName("enzo");
        savedTrader.setID(1);
        savedTrader.setLastName("M");
        traderDao.save(savedTrader);

        savedAccount = new Account();
        savedAccount.setID(1);
        savedAccount.setAmount(1000000.0);
        savedAccount.setTraderId(1);
        accountDao.save(savedAccount);

        savedOrder = new SecurityOrder();
        savedOrder.setID(1);
        savedOrder.setNotes("This is a test notes");
        savedOrder.setAccountId(savedAccount.getID());
        savedOrder.setPrice(101.0);
        savedOrder.setSize(10);
        savedOrder.setStatus(SecurityOrder.Status.FILLED);
        savedOrder.setTicker("FB");
        securityOrderDao.save(savedOrder);


    }

    @After
    public void deleteAll() {
        securityOrderDao.deleteAll();
        accountDao.deleteAll();
        traderDao.deleteAll();
        quoteDao.deleteAll();
    }

    @Test
    public void findAll() {
        List<Position> positions = Lists.newArrayList(positionDao.findAll());
        assertEquals(1, positions.size());
        assertEquals(savedOrder.getAccountId(), positions.get(0).getAccountId());

    }
    @Test
    public void findAllById(){
        Iterable<Position> positions = positionDao.findAllById(Collections.singletonList(savedAccount.getID()));
        assertEquals(positions.iterator().next().getPosition(),savedOrder.getSize());
        assertEquals(positions.iterator().next().getAccountId(),savedOrder.getAccountId());

    }

    @Test
    public void findByAccountIdAndTicker(){
        Optional<Position> position= positionDao.findByAccountIdAndTicker(savedAccount.getID(),savedOrder.getTicker());
        assertEquals(position.get().getPosition(),savedOrder.getSize());
        assertEquals(position.get().getAccountId(),savedOrder.getAccountId());
    }

}