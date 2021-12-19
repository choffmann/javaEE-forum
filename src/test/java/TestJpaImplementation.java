import de.hsfl.group.e.javeeeforum.model.Category;
import de.hsfl.group.e.javeeeforum.model.Creator;
import de.hsfl.group.e.javeeeforum.model.Tag;
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

    // Test register User   -> CHECK ☑️
    // Test Categories      -> CHECK ☑️
    // Test Tags            -> CHECK ☑️
    // Test add new Thread  -> CHECK ☑️
    // Test add Answer to new Thread
    // Test add Comment to Answer to new Thread
    // Check get Creator of new Thread
    // Check get Creator of Answer on Thread


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

        // Set current DateTime
        Date date = new Date();

        Thread thread = new Thread();
        thread.setText("Demo Thread to test function");
        thread.setTitle("Thread #1");
        thread.setCreator(creatorOfThread);
        thread.setCategories(categories);
        thread.setTags(tags);
        thread.setCreatedAt(date);

        manager.persist(thread);
        manager.getTransaction().commit();
    }
}
