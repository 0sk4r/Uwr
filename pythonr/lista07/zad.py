#import Gtk
#import gobject

import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, GObject


class Timer:
    def __init__(self):
        self.window = Gtk.Window()
        self.window.connect("destroy", self.destroy)
        self.window.connect("delete_event", self.delete_event)
        self.window.set_border_width(10)
        self.window.set_title("Minutnik")

        vbox = Gtk.VBox()
        self.window.add(vbox)

        self.label = Gtk.Label("Na jaki czas ustawic?:")
        vbox.pack_start(self.label, True, True, 10)

        hbox = Gtk.HBox()
        vbox.pack_start(hbox, True, True, 0)

        label = Gtk.Label("Czas (s): ")
        hbox.pack_start(label, True, True, 5)

        self.input_entry = Gtk.Entry()
        hbox.pack_start(self.input_entry, True, True, 5)

        button_start = Gtk.Button("Start")
        button_start.connect("clicked", self.start_clicked)
        hbox.pack_start(button_start, True, True, 5)

        vbox.pack_start(Gtk.Label("Predefiniowane:"), True, True, 5)

        hbox = Gtk.HBox()
        vbox.pack_start(hbox, True, True, 10)

        button_eggs = Gtk.Button("Jajka")
        button_eggs.connect("clicked", self.eggs_clicked)
        hbox.pack_start(button_eggs, True, True, 5)

        button_rice = Gtk.Button("Ryz")
        button_rice.connect("clicked", self.rice_clicked)
        hbox.pack_start(button_rice, True, True, 5)

        self.window.show_all()

    def delete_event(widget, event, data=None):
        print "delete event occurred"
        return False

    def destroy(widget, data=None):
        print "destroy"
        Gtk.main_quit()

    def start_clicked(self, sender):
        self.counter = int(self.input_entry.get_text()) - 1
        GObject.timeout_add(1000, self.countdown)

    def eggs_clicked(self, sender):
        self.counter = 100
        GObject.timeout_add(1000, self.countdown)

    def rice_clicked(self, sender):
        self.counter = 200
        GObject.timeout_add(1000, self.countdown)

    def countdown(self):
        if self.counter > 0:
            self.label.set_text("Pozostaly czas: " + str(self.counter) + "s")
            self.counter -= 1
            return True
        else:
            self.label.set_text("GOTOWE!!!")
            return False


if __name__ == "__main__":
    app = Timer()
    Gtk.main()
