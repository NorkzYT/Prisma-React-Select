import React from "react";
import Select from "react-select";
import prisma2 from "../lib/prismadb";

const styles = {
  control: (base) => ({
    ...base,
    "&:hover": {
      borderColor: "blue",
    },
  }),
  dropdownIndicator: (base) => ({
    ...base,
    color: "inherit",
  }),
  singleValue: (base) => ({
    ...base,
    color: "inherit",
  }),
};

export const getServerSideProps = async () => {
  const database = await prisma2.info.findMany({
    where: {
      subject: { information },
    },
  });
  return { props: { database } };
};

const Button = ({ database }) => {
  return (
    <div>
      <div>Select Button</div>
      <Select
        defaultValue={database.subject}
        onClick={() => setShow(false)}
        onChange={(database) => setUserChoice(database.information)}
        options={database}
        styles={styles}
      />
    </div>
  );
};

export default Button;
