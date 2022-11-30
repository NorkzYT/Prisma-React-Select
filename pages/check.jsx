import React, { useState } from "react";
import Select from "react-select";
import prisma1 from "../lib/prismadbone.ts";
/* ---------------------------------------------------------------------------------------------------------- */

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

/* ---------------------------------------------------------------------------------------------------------- */

export const getServerSideProps = async () => {
  const info = await prisma1.info.findMany({
    select: {
      information: true,
      keywords: true,
      subject: true,
    },
  });

  const databaseOptions = info.map((info) => ({
    label: info.subject,
    value: info.information,
  }));

  const databaseLabel = info.map((info) => ({
    label: info.subject,
  }));

  const databaseValue = info.map((info) => ({
    value: info.information,
  }));

  // console.log("database @", records);

  return {
    props: {
      database: {
        records: info,
        options: databaseOptions,
        label: databaseLabel,
        value: databaseValue,
      },
    },
  };
};
/* ---------------------------------------------------------------------------------------------------------- */

const Button = ({ database }) => {
  const [show, setShow] = useState(true);
  const [userChoice, setUserChoice] = useState("");
  // console.log("props", database);
  console.log(userChoice);

  return (
    <div>
      <div>Select Button</div>
      <Select
        id="long-value-select"
        instanceId="long-value-select"
        defaultValue={database.label[0]}
        onClick={() => setShow(false)}
        onChange={(database) => setUserChoice(database.value)}
        options={database.options}
        styles={styles}
      />
    </div>
  );
};

export default Button;

/* ---------------------------------------------------------------------------------------------------------- */