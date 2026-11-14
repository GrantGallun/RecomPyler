def create_image_chaos(self, w, h, iterations, filename, rng_seed):
    # Always use the same sequence of random numbers
    # to get reproductible benchmark
    random.seed(rng_seed)

    im = [[1] * h for i in range(w)]
    point = GVector((self.maxx + self.minx) / 2,
                    (self.maxy + self.miny) / 2, 0)
    for _ in range(iterations):
        point = self.transform_point(point)
        x = (point.x - self.minx) / self.width * w
        y = (point.y - self.miny) / self.height * h
        x = int(x)
        y = int(y)
        if x == w:
            x -= 1
        if y == h:
            y -= 1
        im[x][h - y - 1] = 0

    if filename:
        write_ppm(im, filename)

    return im
