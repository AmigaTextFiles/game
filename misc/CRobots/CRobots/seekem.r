S Holmstead
S Holmstead
/* Seek 'em and Kill 'em */

int angle, range;

main ()
{
    /* main loop */
    while (1)
    {
        /* search for someone to kill */
        drive (angle, 0);
        while (!(range = scan (angle -= 10, 10)));

        /* shoot at him */
        cannon (angle, range);

        /* loop until we loose sight of him */
        while (range = scan (angle = track (angle, 5, 20), 10))
        {
            /* shoot at him */
            cannon (angle, range);

            /* if he is too far away, move in closer */
            if (range > 200)
                drive (angle, 50);
            else
                drive (angle, 0);
        }
    }
}

/* track: pinpoints the enemy (optimized from tiger's routine) */
track (d, r, l)
int d, r, l;
{
    /* check for the end of recursion case */
    if (r <= l)
    {
        /* see if he is still in front of us */
        if (scan (d, r) > 0)
        {
            return (d);
        }
        else
        {
            /* see if he moved left */
            if (scan (d-r, r) > 0)
            {
                return (d-r);
            }
            else
            {
                /* see if he moved right */
                if (scan (d+r, r) > 0)
                {
                    return (d+r);
                }
                else
                {
                    /* can't find him */
                    /* expand our search range and try again */
                    return (track (d, r*2, l));
                }
            }
        }
    }
    else
    {
        /* can't find him, give up */
        return (d);
    }
}

