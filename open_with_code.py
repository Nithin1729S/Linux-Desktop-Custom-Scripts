import os
from gi.repository import Nautilus, GObject

class OpenCodeExtension(GObject.GObject, Nautilus.MenuProvider):
    def menu_activate_cb(self, menu, foldername):
        os.system(f"code \"{foldername}\" &")

    def get_file_items(self, files):
        if len(files) != 1 or not files[0].is_directory():
            return []

        file = files[0]
        srcPath = file.get_location().get_path()

        if srcPath is None:
            return []

        item = Nautilus.MenuItem(
            name="OpenCodeExtension::Open_Dir",
            label="Open with Code",
        )
        item.connect("activate", self.menu_activate_cb, srcPath)
        return [item]

    def get_background_items(self, file):
        if not (file.is_directory() and file.get_uri_scheme() == "file"):
            return []

        currentDir = file.get_location().get_path()

        if currentDir is None:
            return []

        item = Nautilus.MenuItem(
            name="OpenCodeExtension::Open_Background",
            label="Open with Code",
        )
        item.connect("activate", self.menu_activate_cb, currentDir)
        return [item]
