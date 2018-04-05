FROM node:8.9.4-slim

# Install Chrome and Yarn in one RUN command
# to have a single layer. Changing any piece
# of this command will invalidate the layer.
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends git google-chrome-stable \
  && apt-get clean \
  && npm i -g yarn@1.3.2

WORKDIR /app

# ADD will invalidate this layer
# and everything after.
ADD . /app

# This can be anywhere in the config
EXPOSE 4200

# This will always run because
# of the aforementioned ADD.
RUN npm install

ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

CMD ["node", "server.js"]
