const MAX_TEXT_LENGTH = 1024;
const app = Application.currentApplication();
app.includeStandardAdditions = true;

console.log("Start com.dmitrykabanov.sync-archive");
const home = app.systemAttribute("HOME");
const script = home + "/.launchd/sync-drive/sync-drive.sh";
const res = app.doShellScript("zsh " + script);

if (res.length < MAX_TEXT_LENGTH) {
  app.displayDialog(res);
} else {
  app.displayDialog(
    res.substring(0, MAX_TEXT_LENGTH) +
      "\n\nPlease see the full log ~/.launchd/sync-drive/rsync.log."
  );
}

if (res.includes("success")) {
  app.displayNotification("completed successfully", {
    withTitle: "com.dmitrykabanov.sync-drive",
  });
  console.log("Finish com.dmitrykabanov.sync-drive: success");
} else {
  app.displayAlert("com.dmitrykabanov.sync-drive failed", {
    message: "Please see " + script + " and logfiles",
    as: "warning",
  });
  console.log("Finish com.dmitrykabanov.sync-drive: failure");
}
