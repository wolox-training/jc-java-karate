package wbooks;

// imports for parallel execution
import org.junit.jupiter.api.Test;
import com.intuit.karate.Runner;
import com.intuit.karate.Results;
import static org.junit.jupiter.api.Assertions.*;

// imports for reporting
import net.masterthought.cucumber.ReportBuilder;
import net.masterthought.cucumber.Configuration;
import org.apache.commons.io.FileUtils;
import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

class WBooksTest {

    /* TODO health check tests
    @BeforeClass
    public static void beforeClass() throws Exception {
        HealthTest.beforeClass();
    }*/

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:wbooks").parallel(5);
        generateReport(results.getReportDir());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "wbooks");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }

}
