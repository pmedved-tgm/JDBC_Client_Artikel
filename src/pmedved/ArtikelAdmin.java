package pmedved;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.EnumMap;
import java.util.Enumeration;
import java.util.Hashtable;

import javafx.application.Application;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.geometry.Insets;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableColumn.CellEditEvent;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.TreeTableColumn;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.control.cell.TextFieldTableCell;
import javafx.scene.control.cell.TextFieldTreeTableCell;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.scene.text.Font;
import javafx.stage.Stage;
import javafx.util.converter.FloatStringConverter;
import javafx.util.converter.IntegerStringConverter;
import javafx.event.EventHandler;

public class ArtikelAdmin extends Application {

    private TableView<Artikel> table = new TableView<Artikel>();
    private ObservableList<Artikel> data;
    private String inputvar = null;
    protected Hashtable<String, Integer> ver;

    public static void main(String[] args) {
        launch(args);
    }

    @SuppressWarnings("unchecked")
    @Override
    public void start(Stage stage) {
        JDBCClient db = new JDBCClient();
        final Label label1 = new Label("	Search:");
        final TextField tf = new TextField();

        data = FXCollections.observableArrayList();
        data.addAll(db.getAllArticles(inputvar));

        Scene scene = new Scene(new Group());
        stage.setTitle("Artikel Admin");
        stage.setWidth(940);
        stage.setHeight(550);

        final Label label = new Label("Artikel");
        label.setFont(new Font("Arial", 20));


        TableColumn<Artikel, String> artbezCol = new TableColumn<Artikel, String>("Bezeichnung");
        artbezCol.setMinWidth(200);
        artbezCol.setCellValueFactory(
                new PropertyValueFactory<Artikel, String>("artbez"));

        TableColumn<Artikel, String> katbezCol = new TableColumn<Artikel, String>("Kategorie");
        katbezCol.setMinWidth(250);
        katbezCol.setCellValueFactory(
                new PropertyValueFactory<Artikel, String>("katbez"));


        TableColumn<Artikel, Float> bruttprCol = new TableColumn<Artikel, Float>("Brutto Preis");
        bruttprCol.setMinWidth(150);
        bruttprCol.setCellValueFactory(
                new PropertyValueFactory<Artikel, Float>("bruttpr"));

        TableColumn<Artikel, Boolean> isvegetarischCol = new TableColumn<Artikel, Boolean>("Vegetarisch");
        isvegetarischCol.setMinWidth(150);
        isvegetarischCol.setCellValueFactory(
                new PropertyValueFactory<Artikel, Boolean>("isvegetarisch"));

        TableColumn<Artikel, Integer> versionCol = new TableColumn<Artikel, Integer>("Version");
        versionCol.setMinWidth(150);
        versionCol.setCellValueFactory(
                new PropertyValueFactory<Artikel, Integer>("version")
        );

        ver = db.versions;

        Enumeration e = ver.keys();
        while(e.hasMoreElements()) {
            String key = (String) e.nextElement();
            System.out.println("Values: " + ver.get(key) + " Keys: " + key);
        }


        table.setItems(data);
        table.getColumns().addAll(artbezCol, katbezCol, bruttprCol, isvegetarischCol,versionCol);
        table.setMinWidth(900);


        final TextField addartbez = new TextField();
        addartbez.setMaxWidth(artbezCol.getPrefWidth());
        addartbez.setPromptText("Artikelbezeichnung");
        final TextField addkatbez = new TextField();
        addkatbez.setMaxWidth(katbezCol.getPrefWidth());
        addkatbez.setPromptText("Kategorie");
        final TextField addBruttpr = new TextField();
        addBruttpr.setMaxWidth(bruttprCol.getPrefWidth());
        addBruttpr.setPromptText("Brutto Preis");
        final TextField addisvegetarisch = new TextField();
        addisvegetarisch.setMaxWidth(isvegetarischCol.getPrefWidth());
        addisvegetarisch.setPromptText("Vegetarisch");
        final TextField addversion = new TextField();
        addversion.setMaxWidth(isvegetarischCol.getPrefWidth());
        addversion.setPromptText("Version");




        final Button addButton = new Button("Speichern");
        addButton.setOnAction(new EventHandler<ActionEvent>() {
            @Override
            public void handle(ActionEvent e) {
                Artikel a = new Artikel(
                        addartbez.getText(),
                        addkatbez.getText(),
                        Float.parseFloat(addBruttpr.getText()),
                        Boolean.parseBoolean(addisvegetarisch.getText()),
                        Integer.parseInt(addversion.getText()));
                data.add(a);
                db.addArticle(a);
                addartbez.clear();
                addkatbez.clear();
                addBruttpr.clear();
                addisvegetarisch.clear();
                addversion.clear();
            }
        });

        final Button search = new Button("Search");
        search.setOnAction(new EventHandler<ActionEvent>() {
            @Override
            public void handle(ActionEvent e) {
                ObservableList<Artikel> data2 = FXCollections.observableArrayList();

                inputvar = tf.getText();

                data2.addAll(db.getAllArticles(inputvar));
                table.setItems(data2);
                table.refresh();
            }
        });

        final Button change = new Button("change");
        change.setOnAction(new EventHandler<ActionEvent>() {
            @Override
            public void handle(ActionEvent e) {
                System.out.println(table.getSelectionModel().getSelectedItem().getArtbez() + " Wird derzeit bearbeitet");

                try{
                    int trueVer = db.getVersionOf(table.getSelectionModel().getSelectedItem().getArtbez());
                    System.out.println(trueVer);

                    // plaveholderVer = table.getSelectionModel().getSelectedItem().getVersion();

                    if(trueVer == table.getSelectionModel().getSelectedItem().getVersion()){
                        System.out.println("Worked");
                        Artikel palacehold = new Artikel(
                                table.getSelectionModel().getSelectedItem().getArtbez(),
                                table.getSelectionModel().getSelectedItem().getKatbez(),
                                table.getSelectionModel().getSelectedItem().getBruttpr(),
                                table.getSelectionModel().getSelectedItem().getIsvegetarisch(),
                                table.getSelectionModel().getSelectedItem().getVersion()+1);
                        db.saveArticle(palacehold);
                    }else{
                        System.out.println("Daten inzwischen geändert");
                    }
                }catch(NullPointerException ne){
                }


            }
        });

        final HBox hb = new HBox();

        hb.getChildren().addAll(addartbez, addkatbez, addBruttpr, addisvegetarisch, addversion, addButton, change, label1, tf, search);
        hb.setSpacing(3);

        final VBox vbox = new VBox();
        vbox.setSpacing(5);
        vbox.setPadding(new Insets(10, 0, 0, 10));
        vbox.getChildren().addAll(label, table, hb);

        ((Group) scene.getRoot()).getChildren().addAll(vbox);

        stage.setScene(scene);
        stage.show();
    }
}