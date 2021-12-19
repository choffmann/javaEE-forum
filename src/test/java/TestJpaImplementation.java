import de.hsfl.group.e.javeeeforum.model.*;
import de.hsfl.group.e.javeeeforum.model.Thread;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.Date;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

public class TestJpaImplementation {
    private static EntityManager manager;

    @BeforeAll
    public static void initEntityManager() {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("javaEE-forum");
        manager = factory.createEntityManager();
    }

    // Test register Creator
    @Test
    public void testRegisterCreator() {
        Creator creator1 = new Creator();
        creator1.setUsername("choffmann");
        creator1.setEmail("cedrik.hoffmann@stud.hs-flensburg.de");
        creator1.setPassword("secret_password!");
        creator1.setAdmin(true);
        creator1.setScore(10);

        // isAdmin & Score => default value by database
        Creator creator2 = new Creator();
        creator2.setUsername("mustermann");
        creator2.setEmail("max.mustermann@stud.hs-flensburg.de");
        creator2.setPassword("password!");

        manager.getTransaction().begin();
        manager.persist(creator1);
        manager.persist(creator2);

        List<Creator> resultList = manager.createQuery("SELECT c FROM Creator c", Creator.class).getResultList();

        assertEquals(2, resultList.size());
        for (int i = 0; i < resultList.size(); i++) {
            assertNotNull(resultList.get(i).getId());
        }

        Creator result1 = resultList.get(0);
        assertEquals(result1.getUsername(), creator1.getUsername());
        assertEquals(result1.isAdmin(), creator1.isAdmin());

        Creator result2 = resultList.get(1);
        assertEquals(result2.getUsername(), creator2.getUsername());
        assertEquals(result2.isAdmin(), creator2.isAdmin());

        manager.getTransaction().commit();
    }

    // Test add Categories
    @Test
    public void testAddCategory() {
        List<Category> categories = new ArrayList();
        for (int i = 0; i < 5; i++) {
            Category category = new Category();
            category.setText("Category #" + i);
            categories.add(category);
        }

        manager.getTransaction().begin();
        for (int i = 0; i < categories.size(); i++) {
            manager.persist(categories.get(i));
        }

        List<Category> resultList = manager.createQuery("SELECT c FROM Category c", Category.class).getResultList();
        assertEquals(5, resultList.size());
        for (int i = 0; i < resultList.size(); i++) {
            assertNotNull(resultList.get(i).getId());
        }
        manager.getTransaction().commit();
    }

    // Test add Tags
    @Test
    public void testAddTags() {
        List<Tag> tags = new ArrayList();
        for (int i = 0; i < 5; i++) {
            Tag tag = new Tag();
            tag.setTag("Tag #" + i);
            tags.add(tag);
        }

        manager.getTransaction().begin();
        for (int i = 0; i < tags.size(); i++) {
            manager.persist(tags.get(i));
        }

        List<Category> resultList = manager.createQuery("SELECT c FROM Category c", Category.class).getResultList();
        assertEquals(5, resultList.size());
        for (int i = 0; i < resultList.size(); i++) {
            assertNotNull(resultList.get(i).getId());
        }
        manager.getTransaction().commit();
    }

    // Test add new Thread
    @Test
    public void testAddThread() {
        manager.getTransaction().begin();

        // Get User to create new Thread
        Creator creatorOfThread = manager.createQuery("SELECT c FROM Creator c WHERE c.username = 'choffmann'", Creator.class).getSingleResult();
        assertEquals("choffmann", creatorOfThread.getUsername());

        // Get Categories to create new Thread
        Category category1 = manager.createQuery("SELECT c FROM Category c WHERE c.text = 'Category #3'", Category.class).getSingleResult();
        Category category2 = manager.createQuery("SELECT c FROM Category c WHERE c.text = 'Category #4'", Category.class).getSingleResult();
        List<Category> categories = new ArrayList();
        categories.add(category1);
        categories.add(category2);

        // Get Tags to create new Thread
        Tag tag1 = manager.createQuery("SELECT t FROM Tag t WHERE t.tag = 'Tag #1'", Tag.class).getSingleResult();
        Tag tag2 = manager.createQuery("SELECT t FROM Tag t WHERE t.tag = 'Tag #3'", Tag.class).getSingleResult();
        List<Tag> tags = new ArrayList();
        tags.add(tag1);
        tags.add(tag2);

        Thread thread = new Thread();
        thread.setText("Demo Thread to test function");
        thread.setTitle("Thread #1");
        thread.setCreator(creatorOfThread);
        thread.setCategories(categories);
        thread.setTags(tags);
        thread.setCreatedAt(new Date());

        manager.persist(thread);
        manager.getTransaction().commit();
    }

    // Test get user from thread
    @Test
    public void testGetUserFromThread() {
        manager.getTransaction().begin();
        Thread thread = manager.createQuery("SELECT t FROM Thread t WHERE t.title = 'Thread #1'", Thread.class).getSingleResult();
        assertEquals("choffmann", thread.getCreator().getUsername());
        manager.getTransaction().commit();
    }

    // Add Answer to new Thread
    @Test
    public void testAddAnswerToThread() {
        manager.getTransaction().begin();
        Thread thread = manager.createQuery("SELECT t FROM Thread t WHERE t.title = 'Thread #1'", Thread.class).getSingleResult();
        assertEquals("choffmann", thread.getCreator().getUsername());

        Creator creator = manager.createQuery("SELECT c FROM Creator c WHERE c.username = 'mustermann'", Creator.class).getSingleResult();
        assertEquals("mustermann", creator.getUsername());

        Answer answer1 = new Answer();
        answer1.setThread(thread);
        answer1.setCreator(thread.getCreator());
        answer1.setText("A answer to a Thread, maybe this is a helpful answer??");
        answer1.setCreatedAt(new Date());

        Answer answer2 = new Answer();
        answer2.setThread(thread);
        answer2.setCreator(creator);
        answer2.setText("Another answer to a Thread, hopefully this is a more helpful answer??");
        answer2.setCreatedAt(new Date());

        manager.persist(answer1);
        manager.persist(answer2);
        manager.getTransaction().commit();
    }

    // Test comment on Answer
    @Test
    public void testAddCommentToAnswer() {
        manager.getTransaction().begin();
        Answer answersPositive = manager.createQuery("SELECT a FROM Answer a WHERE a.id = 4", Answer.class).getSingleResult();
        Answer answersNegative = manager.createQuery("SELECT a FROM Answer a WHERE a.id = 5", Answer.class).getSingleResult();

        Comment positive = new Comment();
        positive.setCreatedAt(new Date());
        positive.setText("This answer was helpful!");
        positive.setCreator(answersPositive.getCreator());
        positive.setAnswer(answersPositive);

        Comment negative = new Comment();
        negative.setCreatedAt(new Date());
        negative.setText("This answer is bullshit!");
        negative.setCreator(answersNegative.getCreator());
        negative.setAnswer(answersNegative);

        manager.persist(positive);
        manager.persist(negative);
        manager.getTransaction().commit();
    }

    // Test Rate on positive and negative answers
    @Test
    public void testScoreOnAnswers() {
        manager.getTransaction().begin();
        Answer answersPositive = manager.createQuery("SELECT a FROM Answer a WHERE a.id = 4", Answer.class).getSingleResult();
        Answer answersNegative = manager.createQuery("SELECT a FROM Answer a WHERE a.id = 5", Answer.class).getSingleResult();

        // 11 User find this Answer helpful, 1 not
        answersPositive.setScore(10);
        // 1 User find this answer helpful, 10 not
        answersNegative.setScore(-9);

        manager.persist(answersPositive);
        manager.persist(answersNegative);
        manager.getTransaction().commit();
    }
}
