// ==UserScript==
// @match https://www.youtube.com/*
// @match https://astronvim.com/*
// @match https://www.reddit.com/*
// ==/UserScript==

const meta = document.createElement('meta');
meta.name = "color-scheme";
meta.content = "dark light";
document.head.appendChild(meta);
