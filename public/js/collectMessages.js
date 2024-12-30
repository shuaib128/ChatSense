window.onload = function () {
  const hash = window.location.hash.substring(1);
  const params = new URLSearchParams(hash);

  const accessToken = params.get("access_token");
  if (accessToken) {
    console.log("Access Token:", accessToken);
  } else {
    console.error("No token found!");
  }
};
