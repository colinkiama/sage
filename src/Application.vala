/*
 * SPDX-License-Identifier: MIT
 * SPDX-FileCopyrightText: 2021 Colin Kiama <colinkiama@email.com>
 */
public class MyApp : Gtk.Application {
    public MyApp () {
        Object (
            application_id: "com.github.colinkiama.Sage",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this) {
            default_height = 300,
            default_width = 300,
            title = "Hello World"
        };

        var gtk_settings = Gtk.Settings.get_default ();
        var granite_settings = Granite.Settings.get_default ();

        gtk_settings.gtk_application_prefer_dark_theme = (
            granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK
        );

        granite_settings.notify["prefers-color-scheme"].connect (() => {
            gtk_settings.gtk_application_prefer_dark_theme = (
                granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK
            );
        });

        var hello_button = new Gtk.Button.with_label ("Say Hello");
        var hello_label = new Gtk.Label (null);

        var rotate_button = new Gtk.Button.with_label ("Rotate");
        var rotate_label = new Gtk.Label ("Horizontal");

        var grid = new Gtk.Grid () {
            column_spacing = 6,
            row_spacing = 6
        };

        // add first row of widgets
        grid.attach (hello_button, 0, 0, 1, 1);

        grid.attach_next_to (
            hello_label, hello_button, Gtk.PositionType.RIGHT, 1, 1
        );

        // add second row of widgets
        grid.attach (rotate_button, 0, 1);

        grid.attach_next_to (
            rotate_label, rotate_button, Gtk.PositionType.RIGHT, 1, 1
        );

        main_window.add (grid);

        hello_button.clicked.connect(() => {
            hello_label.label = "Hello World!";
            hello_button.sensitive = false;
        });

        rotate_button.clicked.connect (() => {
            rotate_label.angle = 90;
            rotate_label.label = "Vertical";
            rotate_button.sensitive = false;
        });

        main_window.show_all ();
    }

    public static int main (string[] args) {
        return new MyApp ().run (args);
    }
}
