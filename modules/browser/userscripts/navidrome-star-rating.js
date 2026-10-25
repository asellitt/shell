// ==UserScript==
// @name         Navidrome star rating
// @namespace    asellitt
// @version      1.0
// @description  Clickable 5-star rating for the current song in the now-playing bar
// @match        https://navidrome.host/*
// @run-at       document-idle
// @grant        none
// ==/UserScript==

(function () {
  const STAR_COUNT = 5;
  const CONTAINER_ID = "nd-star-rating";

  let renderedSongId = null;

  function subsonicUrl(restBase, command, params) {
    const username = localStorage.getItem("username");
    const token = localStorage.getItem("subsonic-token");
    const salt = localStorage.getItem("subsonic-salt");
    if (!username || !token || !salt) return null;
    const query = new URLSearchParams({
      u: username,
      t: token,
      s: salt,
      f: "json",
      v: "1.8.0",
      c: "navidrome-star-rating",
      ...params,
    });
    return `${restBase}/${command}?${query}`;
  }

  function currentSong() {
    const audio = document.querySelector("audio");
    if (!audio || !audio.src.includes("/rest/")) return null;
    const streamParams = new URL(audio.src).searchParams;
    // Direct streams carry the song id as `id`; transcoded streams as `mediaId`.
    const songId = streamParams.get("id") || streamParams.get("mediaId");
    if (!songId) return null;
    const restBase = audio.src.slice(0, audio.src.indexOf("/rest/") + "/rest".length);
    return { songId, restBase };
  }

  async function fetchRating(song) {
    const url = subsonicUrl(song.restBase, "getSong", { id: song.songId });
    if (!url) return 0;
    const response = await fetch(url);
    const payload = await response.json();
    const songDetails = payload["subsonic-response"]?.song;
    return songDetails?.userRating || 0;
  }

  async function saveRating(song, rating) {
    const url = subsonicUrl(song.restBase, "setRating", { id: song.songId, rating });
    if (!url) return;
    await fetch(url);
  }

  function renderStars(container, song, rating) {
    container.textContent = "";
    for (let starValue = 1; starValue <= STAR_COUNT; starValue++) {
      const star = document.createElement("span");
      const glyph = starValue <= rating ? "★" : "☆";
      star.textContent = glyph;
      star.style.cursor = "pointer";
      star.style.padding = "0 1px";
      star.title = `Rate ${starValue} star${starValue === 1 ? "" : "s"}`;
      star.addEventListener("click", async (event) => {
        event.stopPropagation();
        const clearingCurrentRating = starValue === rating;
        const newRating = clearingCurrentRating ? 0 : starValue;
        await saveRating(song, newRating);
        renderStars(container, song, newRating);
      });
      container.appendChild(star);
    }
  }

  function ensureContainer() {
    const existing = document.getElementById(CONTAINER_ID);
    if (existing) return existing;
    const controls = document.querySelector(".music-player-panel .player-content");
    const titleArea = document.querySelector(".music-player-panel .progress-bar-content");
    const parent = controls || titleArea;
    if (!parent) return null;
    const container = document.createElement("div");
    container.id = CONTAINER_ID;
    Object.assign(container.style, {
      display: "flex",
      alignItems: "center",
      fontSize: "18px",
      color: "#ffb400",
      userSelect: "none",
    });
    parent.prepend(container);
    return container;
  }

  async function refresh() {
    const song = currentSong();
    const container = ensureContainer();
    if (!song || !container) return;
    const alreadyRendered = song.songId === renderedSongId && container.childElementCount > 0;
    if (alreadyRendered) return;
    renderedSongId = song.songId;
    const rating = await fetchRating(song);
    // A track change during the fetch means a newer refresh owns the container.
    if (renderedSongId === song.songId) renderStars(container, song, rating);
  }

  setInterval(refresh, 1000);
})();
