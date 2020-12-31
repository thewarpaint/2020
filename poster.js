const { readFileSync } = require('fs');
const { safeLoad } = require('js-yaml');
const { WebClient } = require('@slack/web-api');

const {
  SLACK_TOKEN,
} = process.env;

const daysPath = './_data/days.yml';
const conversationId = 'C01GZTLES1J';
const webClient = new WebClient(SLACK_TOKEN);
const homepage = 'https://dosmilveinte.mx';

async function main() {
  const currentDate = getCurrentDate();
  const daysData = getDaysData();
  const currentDateData = daysData[currentDate];

  await postPageLink(currentDate);

  currentDateData.covers.forEach(async (cover) => {
    await postCover(cover);
  });
}

function getCurrentDate() {
  // Good enough way of getting the current date for GMT-6
  const offset = -6 * 60 * 60 * 1000;
  const mexicoCityDate = new Date(new Date().getTime() + offset);

  return mexicoCityDate.toISOString().substring(0, 10);
}

function getDaysData() {
  try {
    return safeLoad(readFileSync(daysPath, 'utf8'));
  } catch (e) {
    console.log(`Couldn't load days data from ${daysPath}`, e);

    return {};
  }
}

async function postPageLink(date) {
  const dateWithSlashes = date.replace(/-/g, '/');

  await sendSlackMessage(`${homepage}/${dateWithSlashes}`);
}

async function postCover(cover) {
  await sendSlackMessage(`${homepage}${cover.imageUrl}`);
}

async function sendSlackMessage(message) {
  // See: https://api.slack.com/methods/chat.postMessage
  const result = await webClient.chat.postMessage({ channel: conversationId, text: message });

  console.log('Message sent:', result);
}

main()
  .catch((e) => {
    debug(`Error posting covers: ${e.message} ${e.stack}`);
  });
