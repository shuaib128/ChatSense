/**Group of all the App buttons */
const discord_button = document.getElementById("discord");
const facebook_button = document.getElementById("facebook");
const instagram_button = document.getElementById("instagram");
const messenger_button = document.getElementById("messenger");
const slack_button = document.getElementById("slack");

const CLIENTID = window.env.DISCORD_CLIENDID;
const DISCORD_STATE = window.env.DISCORD_STATE;

discord_button.addEventListener("click", () => {
  const clientId = CLIENTID;
  const redirectUri = encodeURIComponent(
    "http://localhost:8000/pages/collect_messages.html"
  );
  const scope = "identify";
  const state = DISCORD_STATE;

  const oauth2Url = `https://discord.com/oauth2/authorize?response_type=token&client_id=${clientId}&scope=${scope}&redirect_uri=${redirectUri}&state=${state}`;
  window.location.href = oauth2Url;
});

facebook_button.addEventListener("click", () => {
  console.log("Facebook");
});

instagram_button.addEventListener("click", () => {
  console.log("Instagram");
});

messenger_button.addEventListener("click", () => {
  console.log("Messenger");
});

slack_button.addEventListener("click", () => {
  console.log("Slack");
});
