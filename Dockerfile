FROM node:10.16.0-alpine

WORKDIR /tuxts-frontend

EXPOSE 3000
CMD ["npm", "run", "dev"]
