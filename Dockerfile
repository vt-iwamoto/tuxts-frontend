FROM node:10.16.0-alpine

WORKDIR /tuxts-frontend

ARG PORT=3000
EXPOSE $PORT
ENV PORT ${PORT:-3000}
CMD ["npm", "run", "dev"]
