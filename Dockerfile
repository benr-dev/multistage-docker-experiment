FROM node:16 AS base
FROM node:16-alpine AS runtime

FROM base AS builder
WORKDIR /usr
COPY package.json ./
COPY tsconfig.json ./
COPY src ./src
RUN npm install && npm run build

FROM runtime AS production
WORKDIR /usr
COPY package.json ./
RUN npm install --only=production
COPY --from=builder /usr/dist ./dist
CMD ["npm","run","run"]
