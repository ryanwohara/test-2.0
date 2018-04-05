FROM node:8.9.4-slim

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends git google-chrome-stable \
  && apt-get clean \
  && npm i -g yarn@1.3.2

WORKDIR /app
ADD . /app
EXPOSE 4200

RUN yarn install

ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

CMD ["node", "server.js"]
