import pandas as pd
import math


class Q3:

    data = pd.DataFrame({
        "members": ["AB", "BC", "CD", "DE", "FG", "GH", "HI", "IJ", "AF", "BG", "CH", "DI", "EJ", "AG", "BH", "CI", "DJ"],
        "N_t_max": [167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580],
        "N_c_max": [167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 84940.28, 84940.28, 84940.28, 84940.28],
    })


class Q5(Q3):

    data = pd.concat([Q3.data, pd.DataFrame({
        "force type": ["T", "T", "T", "N", "N", "C", "C", "C", "T", "T", "T", "C", "C", "C", "C", "C", "T"],
        "coefficient of P": [1/3, 2/3, 1, 0, 0, 1/3, 2/3, 1, 1/3, 1/3, 1/3, 1, 1, math.sqrt(2)/3, math.sqrt(2)/3, math.sqrt(2)/3, math.sqrt(2)],
    })], axis=1)

    @classmethod
    def calc_member_forces(cls, P):
        p = cls.data.loc[:, ["members", "force type", "coefficient of P"]]
        p["P (N)"] = p["coefficient of P"] * P
        return p


class Q6(Q5):

    @classmethod
    def max_load(cls):

        t = cls.data.loc[cls.data["force type"] == "T"]
        t["P_max"] = t["N_t_max"] / t["coefficient of P"]
        max_load_t = t["P_max"].min()

        c = cls.data.loc[cls.data["force type"] == "C"]
        c["P_max"] = c["N_t_max"] / c["coefficient of P"]
        max_load_c = c["P_max"].min()

        return max_load_t if max_load_t < max_load_c else max_load_c


class Q7:

    data = pd.DataFrame({
        "members": ["AB", "BC", "CD", "DE", "FG", "GH", "HI", "IJ", "AF", "BG", "CH", "DI", "EJ", "AG", "BH", "DH", "EI"],
        "force type": ["T", "T", "T", "T", "N", "C", "C", "N", "T", "T", "N", "C", "N", "C", "C", "T", "C"],
        "coefficient of P": [1/3, 2/3, 2/3, 1, 0, 1/3, 1, 0, 1/3, 1/3, 0, 1/3, 0, math.sqrt(2)/3, math.sqrt(2)/3, math.sqrt(2)/3, math.sqrt(2)],
        "N_t_max": [167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580],
        "N_c_max": [167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 167580, 84940.28, 84940.28, 84940.28, 84940.28],
    })

    @classmethod
    def max_load(cls):

        t = cls.data.loc[cls.data["force type"] == "T"]
        t["P_max"] = t["N_t_max"] / t["coefficient of P"]
        max_load_t = t["P_max"].min()

        c = cls.data.loc[cls.data["force type"] == "C"]
        c["P_max"] = c["N_t_max"] / c["coefficient of P"]
        max_load_c = c["P_max"].min()

        return max_load_t if max_load_t < max_load_c else max_load_c
