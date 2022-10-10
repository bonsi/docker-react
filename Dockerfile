FROM node:16-alpine as builder
USER node
RUN mkdir -p /home/node/app
WORKDIR /home/node/app
COPY --chown=node:node package.json .
# RUN npm install
RUN yarn install
COPY --chown=node:node . .
RUN npm run build

FROM nginx
COPY --from=builder /home/node/app/build /usr/share/nginx/html
# default command of the image is already starting nginx