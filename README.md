# deploy-dessn-bright-transients

Clone ATC repo to `app/` then run `docker build` there with appropriate arguments.
The result is a Docker image that can run the Flask app with Gunicorn like

    gunicorn pub:app -b :8000 --name pub:app --log-level=debug --log-file=-

Since `ATC_STATIC_URL_PATH` is not set, static assets are served up from the typical Flask `static/` directory.
To run you need to set other configurables.
But it won't really run because you need MongoDB.
