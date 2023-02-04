const app = Application.currentApplication();
app.includeStandardAdditions = true;

console.log("Start com.dmitrykabanov.sync-archive");
const home = app.systemAttribute("HOME");
const script = home + "/.launchd/sync-drive/sync-drive.sh";
const res = app.doShellScript("zsh " + script);
app.displayDialog(res);

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
