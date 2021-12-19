import de.hsfl.group.e.javeeeforum.dao.*;
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

        CreatorDao creatorDao = new CreatorDao();
        creatorDao.addElement(creator1);
        creatorDao.addElement(creator2);

        List<Creator> creators = creatorDao.getAll();
        assertEquals(2, creators.size());
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

        CategoryDao categoryDao = new CategoryDao();
        for (int i = 0; i < categories.size(); i++) {
            categoryDao.addElement(categories.get(i));
        }

        List<Category> resultList = categoryDao.getAll();
        assertEquals(5, resultList.size());
        for (int i = 0; i < resultList.size(); i++) {
            assertNotNull(resultList.get(i).getId());
        }
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

        TagDao tagDao = new TagDao();
        for (int i = 0; i < tags.size(); i++) {
            tagDao.addElement(tags.get(i));
        }

        List<Tag> resultList = tagDao.getAll();
        assertEquals(5, resultList.size());
        for (int i = 0; i < resultList.size(); i++) {
            assertNotNull(resultList.get(i).getId());
        }
    }

    // Test add new Thread
    @Test
    public void testAddThread() {
        manager.getTransaction().begin();

        // Get User to create new Thread
        CreatorDao creatorDao = new CreatorDao();
        Creator creatorOfThread = creatorDao.getById(3L);
        assertEquals("choffmann", creatorOfThread.getUsername());

        // Get Categories to create new Thread
        CategoryDao categoryDao = new CategoryDao();
        Category category1 = categoryDao.getById(12L);
        Category category2 = categoryDao.getById(14L);
        List<Category> categories = new ArrayList();
        categories.add(category1);
        categories.add(category2);

        // Get Tags to create new Thread
        TagDao tagDao = new TagDao();

        Tag tag1 = tagDao.getById(7L);
        Tag tag2 = tagDao.getById(10L);
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

        ThreadDao threadDao = new ThreadDao();
        threadDao.addElement(thread);
    }

    // Test get user from thread
    @Test
    public void testGetUserFromThread() {
        ThreadDao threadDao = new ThreadDao();
        Thread thread = threadDao.getById(2L);
        assertEquals("choffmann", thread.getCreator().getUsername());
    }

    // Add Answer to new Thread
    @Test
    public void testAddAnswerToThread() {
        ThreadDao threadDao = new ThreadDao();
        Thread thread = threadDao.getById(2L);
        assertEquals("choffmann", thread.getCreator().getUsername());

        CreatorDao creatorDao = new CreatorDao();
        Creator creator = creatorDao.getById(4L);
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

        AnswerDao answerDao = new AnswerDao();
        answerDao.addElement(answer1);
        answerDao.addElement(answer2);
    }

    // Test comment on Answer
    @Test
    public void testAddCommentToAnswer() {
        AnswerDao answerDao = new AnswerDao();
        Answer answersPositive = answerDao.getById(9L);
        Answer answersNegative =  answerDao.getById(8L);

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

        CommentDao commentDao = new CommentDao();
        commentDao.addElement(positive);
        commentDao.addElement(negative);
    }

    // Test Rate on positive and negative answers
    @Test
    public void testScoreOnAnswers() {
        AnswerDao answerDao = new AnswerDao();
        Answer answersPositive = answerDao.getById(9L);
        Answer answersNegative =  answerDao.getById(8L);

        // 11 User find this Answer helpful, 1 not
        answersPositive.setScore(10);
        answersPositive.setModifiedAt(new Date());
        // 1 User find this answer helpful, 10 not
        answersNegative.setScore(-9);
        answersNegative.setModifiedAt(new Date());

        answerDao.updateElement(answersPositive);
        answerDao.updateElement(answersNegative);
    }
}
